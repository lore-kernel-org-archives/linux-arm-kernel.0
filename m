From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Mar 2012 13:43:23 -0800
Subject: [PATCH v2 0/6] ARM: Tegra: cleanup patches from Arnd Bergmann
In-Reply-To: <4F513DE3.9020707@signal11.us>
References: <1330721884-8495-1-git-send-email-alan@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861A54@HQMAIL01.nvidia.com>
 <4F513DE3.9020707@signal11.us>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861A73@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Ott wrote at Friday, March 02, 2012 2:39 PM:
> On 03/02/2012 04:04 PM, Stephen Warren wrote:
> > Alan Ott wrote at Friday, March 02, 2012 1:58 PM:
> >> Sorry for the mess yesterday....
> >> This is V2 of Arnd's Patch series from yesterday. Hopefully this one will be
> >> smoother.
> > There was feedback on at least patches 4 and 5 that doesn't appear to
> > have been incorporated into this updated version.
...
> For patch #5 (ARM: tegra: USB_ULPI needs USB), it didn't look to me like
> there was a resolution on that thread yesterday. On reading it again, if
> we change
>     select USB_ULPI if USB_SUPPORT
> to:
>     select USB_ULPI if USB
> for both Tegra 2 and 3, does that satisfy you and Arnd?

I believe so yes. Thanks.

-- 
nvpublic
