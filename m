From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Apr 2014 09:50:29 +0100
Subject: [PATCH v3 part1 07/11] ARM64 / ACPI: Introduce
 arch_fix_phys_package_id() for cpu topology
In-Reply-To: <535DC431.4000900@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
 <20140425145249.GP12304@sirena.org.uk>
 <535DC431.4000900@linaro.org>
Message-ID: <20140428085029.GB15125@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:00:01AM +0800, Hanjun Guo wrote:

> Since platform software (firmware) knows the topology of the system, if
> ACPI describes a slot number for this CPU, I think we can use it
> unconditionally.

Right, the only concern with that is upsetting the scheduler but since
x86 does the same thing presumably this is safe.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/b84429af/attachment.sig>
