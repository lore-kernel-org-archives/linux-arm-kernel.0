From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 12:05:37 +0100
Subject: [PATCH v3 00/10] Support for Cortex-M Prototyping System
In-Reply-To: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <22011981.Gqc7zXAZ81@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 10:08:05 Vladimir Murzin wrote:
> Hi,
> 
> This patch series provide the basic support for running ucLinux on V2M-MPS2
> platform.
> 
> With these patches applied ucLinux can be run on both HW and FVP models
> with Cortex-M3/M4/M7 configurations.

Looks very nice overall now. I have mentioned a few details that I noticed
but no show-stoppers.

Most important question for me is how this is going to be maintained
in the long run. Can you add a patch to list the added files in
MAINTAINERS?

My preference from the arm-soc perspective would be to get pull requests for
this together with vexpress and juno through the existing maintainers
(Liviu, Sudeep, Lorenzo), and have you send your patches to them. Does
that work for you all?

	Arnd
