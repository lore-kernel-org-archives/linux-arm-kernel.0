From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 12 Feb 2013 19:29:39 +0530
Subject: [PATCH] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <511a2153.294e420a.5385.ffffd3a0@mx.google.com>
References: <511a2153.294e420a.5385.ffffd3a0@mx.google.com>
Message-ID: <CAOh2x=m5J43qr-c8-nx9KNpRVMPCBE-oKsFhf3Ux+TArVuS3Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 4:32 PM,  <manjunath.goudar@linaro.org> wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>
> Separate the SPEAr host controller driver from ehci-hcd host code
> into its own driver module.
>
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: linux-usb at vger.kernel.org
> Cc: spear-devel at list.st.com

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
