From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 5 May 2016 11:44:38 -0700
Subject: [PATCH v4 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
In-Reply-To: <CAAFb_vp+oxHc6YD24zPr0o6Pt9Jt1_LsT14VUQGBKXBpvNAj_Q@mail.gmail.com>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160406173140.GB38452@dtor-ws>
 <CAGVrzcbCZn6RYFwJTkffkct1DiiG+tBJnKELDn32T38_s5mjOg@mail.gmail.com>
 <CAAFb_vp+oxHc6YD24zPr0o6Pt9Jt1_LsT14VUQGBKXBpvNAj_Q@mail.gmail.com>
Message-ID: <20160505184438.GA25689@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Raveendra,

On Thu, May 05, 2016 at 11:17:00AM +0530, Raveendra Padasalagi wrote:
> Thanks Dmitry and Florian.
> 
> Hi Dmitry,
> 
> I understand the dts changes are really needed for the touch screen
> driver changes made in this patch. But currently there are no deployed
> systems/customer's using this driver. So please pull the driver changes
> and I will follow up to make sure dts changes also goes in.
> 
> Below is the latest patch set pushed.
> 
> https://lkml.org/lkml/2016/3/24/45

I have the driver, binding doc changes, and changes to
arch/arm/boot/dts/bcm-cygnus.dtsi as
74813cebd678dd471b4fcd7d3019aecab9dbcedd in my 'next' branch, so it will
be merged in the next merge window.

Thanks.

-- 
Dmitry
