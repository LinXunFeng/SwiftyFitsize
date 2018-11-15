//
//  SwiftFitSizeOC.h
//  Pods
//
//  Created by LinXunFeng on 2018/11/15.
//

#ifndef SwiftFitSizeOC_h
#define SwiftFitSizeOC_h

/** ================== ~ ================== */

#define SF_Font(font) \
font.sf

#define SF_Int(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sf_int:value]

#define SF_Float(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sf_float:value]

#define SF_Point(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sf_point:value]

#define SF_Size(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sf_size:value]

#define SF_Rect(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sf_rect:value]

#define SF_EdgeInsets(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sf_EdgeInsets:value]

/** ================== ≈ ================== */

#define SFZ_Font(font) \
font.sfz

#define SFZ_Int(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sfz_int:value]

#define SFZ_Float(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sfz_float:value]

#define SFZ_Point(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sfz_point:value]

#define SFZ_Size(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sfz_size:value]

#define SFZ_Rect(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sfz_rect:value]

#define SFZ_EdgeInsets(value) \
[[SwiftyFitsize sharedSwiftyFitsize] sfz_EdgeInsets:value]


#endif /* SwiftFitSizeOC_h */
