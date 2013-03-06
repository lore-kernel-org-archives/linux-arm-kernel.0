From: bp@alien8.de (Borislav Petkov)
Date: Wed, 6 Mar 2013 12:16:00 +0100
Subject: [PATCH v3 -next 5/5] Kconfig: Make x86 and arm kernels default
 to the LZ4-compressed
In-Reply-To: <51371320.6000002@openwrt.org>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
 <5135DF44.2040806@openwrt.org>
 <20130305150845.0d19a2875d39dac5d03b4b62@linux-foundation.org>
 <51371320.6000002@openwrt.org>
Message-ID: <20130306111600.GA30724@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 10:57:52AM +0100, Florian Fainelli wrote:
> If we want to have more coverage, how about importing the lz4demo
> utility source code to tools/lz4/

That looks like on overkill to me, besides I don't think that's the
purpose of tools/. Maybe everyone who wants to test this, should install
the tool and go wild without disturbing the default.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
