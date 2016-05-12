From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 May 2016 10:08:57 -0700
Subject: [PATCH 5/8] ARM: dts: AM437X-GP-EVM: Remove redundant regulator
 compatibles
In-Reply-To: <1462945691-904-6-git-send-email-j-keerthy@ti.com>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-6-git-send-email-j-keerthy@ti.com>
Message-ID: <20160512170857.GS5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Keerthy <j-keerthy@ti.com> [160510 22:56]:
> With the device tree parsing using the regulator framework
> there is a no longer a need for separate compatibles for
> individual regulator nodes. Hence removing them all.

Please resend the dts related clean-up patches separately
once the rest of the dependencies are merged. I'm unable to
keep track of these dependencies myself :)

Regards,

Tony
