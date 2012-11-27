From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Nov 2012 10:01:22 +0900
Subject: [PATCH] ARM: Exynos: Remove unused non-dt support for dwmci
 controller
In-Reply-To: <CAH9JG2X_=Vr=52BY=vjZVtf9fzSox2KMjXGr0U4uAJu6MHjwQw@mail.gmail.com>
References: <1353914155-1716-1-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2X_=Vr=52BY=vjZVtf9fzSox2KMjXGr0U4uAJu6MHjwQw@mail.gmail.com>
Message-ID: <15d601cdcc3a$b7743c30$265cb490$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 11/26/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> > With device tree support enabled for dwmci controller, the unused non-dt
> > support
> > for dwmci controller can be removed.
> 
> Are there no problem to use legacy board? e.g., universal_c210.
> 
I cannot find anywhere the exynos4_dwmci_set_platdata() and
exynos4_device_dwmci are used.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
