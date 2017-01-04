From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 4 Jan 2017 10:57:13 +0100
Subject: [PATCH] drm/meson: Fix plane atomic check when no crtc for the
 plane
In-Reply-To: <20170104091020.rvikywzzfsqxxp5t@phenom.ffwll.local>
References: <1483435254-27955-1-git-send-email-narmstrong@baylibre.com>
 <20170104091020.rvikywzzfsqxxp5t@phenom.ffwll.local>
Message-ID: <21996aca-9bcb-fe88-390b-79c28189b27d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2017 10:10 AM, Daniel Vetter wrote:
> On Tue, Jan 03, 2017 at 10:20:54AM +0100, Neil Armstrong wrote:
>> When no CRTC is associated with the plane, the meson_plane_atomic_check()
>> call breaks the kernel with an Oops.
>>
>> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Makes sense, pls send a pull request with this to Dave.
> -Daniel

Hi Daniel,

OK, I will push this one with the CVBS fixes I just pushed.

Thanks,
Neil
