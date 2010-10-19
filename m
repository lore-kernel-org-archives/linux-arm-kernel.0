From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Oct 2010 11:21:50 +0530
Subject: [PATCH V2 19/69] USB host: Adding USB ehci & ohci support for
	spear platform
In-Reply-To: <c566b56b02b0bccd220a3d0e90d40a845ab97175.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<c566b56b02b0bccd220a3d0e90d40a845ab97175.1285933331.git.viresh.kumar@st.com>
Message-ID: <4CBD31F6.8030000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2010 05:25 PM, Viresh KUMAR wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
> 
> This patch adds support for ehci and ohci controller in the SPEAr platform
> 
> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/usb/Kconfig           |    2 +
>  drivers/usb/host/ehci-hcd.c   |    5 +
>  drivers/usb/host/ehci-spear.c |  211 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/ohci-hcd.c   |    5 +
>  drivers/usb/host/ohci-spear.c |  240 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 463 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/host/ehci-spear.c
>  create mode 100644 drivers/usb/host/ohci-spear.c
> 

David,

Does this patch looks fine to you or are there any more suggestions??

--
viresh.
