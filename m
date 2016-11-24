From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Thu, 24 Nov 2016 23:39:26 +0530
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <5837246D.5080106@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc> <5835BEBA.8050905@arm.com>
 <20161124172826.GB3524@afzalpc> <5837246D.5080106@arm.com>
Message-ID: <20161124180926.GB5258@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 24, 2016 at 05:33:33PM +0000, Vladimir Murzin wrote:

> Make sure you have ARM_MPU disabled, otherwise it will die early (I keep
> proper patch for that here).

Hmm.., thanks, that is enabled here, will disable it & proceed.

Regards
afzal
