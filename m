From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Apr 2013 10:08:12 -0700
Subject: [GIT PULL] ARM: OMAP2+: standardize integration for AES &
 SHA/MD5 IP blocks for 3.10
In-Reply-To: <alpine.DEB.2.00.1303302244540.6436@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303302244540.6436@utopia.booyaka.com>
Message-ID: <20130401170811.GL10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130330 15:51]:
> Hi Tony,
> 
> The following changes since commit 78e52e026d288aad88b46bff0d94b05e145c4583:
> 
>   ARM: OMAP2+: clock data: Remove CK_* flags (2013-03-18 09:57:39 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.10
> 
> for you to fetch changes up to 1cb804b93f506dfba5fd684a8ea63706aaa8e709:
> 
>   ARM: AM33XX: hwmod: Update and uncomment AES0 module data (2013-03-30 15:52:17 -0600)
> 
> ----------------------------------------------------------------
> For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
> code and data to use hwmod and omap_device. This is a prerequisite for
> moving the hwmod code out of arch/arm.
> 
> Basic test logs are available at:
> 
>    http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.10/20130330155313/

Thanks pulling into omap-for-v3.10/crypto.

Regards,

Tony
 
