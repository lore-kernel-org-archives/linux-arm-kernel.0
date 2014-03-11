From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 11:17:11 +0000
Subject: [PATCH 2/3] ARM: STi: stih416-b2020: Explicitly include STiH416
 Pinctrl bindings
In-Reply-To: <531EEADF.5060001@st.com>
References: <1394533324-20299-1-git-send-email-lee.jones@linaro.org>
 <1394533324-20299-2-git-send-email-lee.jones@linaro.org>
 <531EEADF.5060001@st.com>
Message-ID: <20140311111711.GC21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  #include "stih41x-b2020.dtsi"
> >  / {
> >          model = "STih416 B2020 REV. E";
> >
> 
> For the next revision, could you please add kernel at stlinux.com in cc?

Ah yes, of course. My mistake. I used the wrong flag when sending the
patches '--arm' instaed of '--st-arm'. 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
