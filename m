From: vincent.abriou@st.com (Vincent ABRIOU)
Date: Tue, 8 Aug 2017 10:03:00 +0000
Subject: [PATCH 5/8] drm: Nuke drm_atomic_helper_plane_set_property
In-Reply-To: <20170725080122.20548-6-daniel.vetter@ffwll.ch>
References: <20170725080122.20548-1-daniel.vetter@ffwll.ch>
 <20170725080122.20548-6-daniel.vetter@ffwll.ch>
Message-ID: <d7a0f3da-4254-a694-5975-db6fe395461f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/25/2017 10:01 AM, Daniel Vetter wrote:
> It's dead code, the core handles all this directly now. This also
> allows us to unexport drm_atomic_helper_plane_set_property.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

[...]

>   drivers/gpu/drm/sti/sti_cursor.c                |  1 -
>   drivers/gpu/drm/sti/sti_gdp.c                   |  1 -
>   drivers/gpu/drm/sti/sti_hqvdp.c                 |  1 -

Acked-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent
