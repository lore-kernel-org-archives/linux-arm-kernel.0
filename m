From: olof@lixom.net (Olof Johansson)
Date: Thu, 24 Sep 2015 16:50:17 -0700
Subject: [PATCH] drm: sti: adapt DT to fix probe/bind issues in DRM driver
In-Reply-To: <1443037683-6621-1-git-send-email-maxime.coquelin@st.com>
References: <1443037683-6621-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <20150924235017.GB26500@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 09:48:03PM +0200, Maxime Coquelin wrote:
> From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> STI drm drivers probe and bind using component framework was incorrect.
> In addition to drivers fix DT update is needed to make all sub-components
> become childs of sti-display-subsystem.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
> Hi Arnd, Olof & Kevin,
> 
> This patch has its driver counterpart merged in v4.3-rc1.
> As missing in v4.3, the display is now broken on STiH07 and STiH410 platforms.
> 
> I have only this single patch for v4.3-rc fixes, so can you pick it directly,
> or I should send a pull-request anyway?

Applied directly, since I had to fixup the patch subject. Thanks!


-Olof
