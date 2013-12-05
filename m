From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Dec 2013 18:16:06 +0000
Subject: [PATCH 1/2] cpufreq: enable ARM drivers on arm64
In-Reply-To: <1386202994-30784-2-git-send-email-robherring2@gmail.com>
References: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
 <1386202994-30784-2-git-send-email-robherring2@gmail.com>
Message-ID: <20131205181606.GY29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 06:23:13PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
> drivers. The power menu is needed for OPP support. At least on Calxeda
> systems, the same cpufreq driver is used for arm and arm64 based
> systems.

If this needs any revisions (I'd be surprised but...) can you please
keep me on the CCs?  I intend to pull this into LSK if that's OK since I
was about to do roughly the same thing for it and upstream the result.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/38178928/attachment.sig>
