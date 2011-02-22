From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Feb 2011 07:30:35 -0800
Subject: [PATCH 7/7] ARM: tegra: clock: Disable clocks left on by
	bootloader
In-Reply-To: <AANLkTi==wykFCCjamRNh2ngEaubgeLqmZ7Mv9OsH=0cL@mail.gmail.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-8-git-send-email-ccross@android.com>
	<AANLkTikNSEyjdL0Lchmm-bFxD00omkGLq6Q6Yyjy51Ov@mail.gmail.com>
	<AANLkTi==wykFCCjamRNh2ngEaubgeLqmZ7Mv9OsH=0cL@mail.gmail.com>
Message-ID: <AANLkTinm70LbG8-H7RHndOzkP9vcnu5GhnhKh_LHSzaP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 22, 2011 at 12:05 AM, Colin Cross <ccross@android.com> wrote:

> It doesn't need to be an early_param, I can make it a __setup.

Sounds good.

>> Also, Documentation/kernel-parameters.txt should be updated with it.
> Is it really worth adding every debug flag on every platform to
> kernel-parametes.txt? ?I could add the flag to the warning message
> instead.

It looks like most arm sub-archs haven't added theirs, so it's OK to
leave out. I'm not too bothered either way myself.


-Olof
