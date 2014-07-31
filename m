From: bp@alien8.de (Borislav Petkov)
Date: Thu, 31 Jul 2014 15:17:02 +0200
Subject: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl>
References: <9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl>
 <20140731113324.GB4375@pd.tnic>
 <808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl>
Message-ID: <20140731131702.GC4375@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 02:13:48PM +0200, Michal Simek wrote:
> Mixing two drivers in the one file is not a good idea because with
> more memory controllers it is just a mess and you are not able to
> cover all cases.

Why is it a mess?

> If this is just about providing uniq number we can easily extend
> binding and provide that uniq value. That's remind me solution with
> edac_mc_get_id() can caused that you won't have exact number all the
> time - depends on driver loading (deferred probing too).

-ENOPARSE for this sentence.

> One option via DT can be via aliases where you can easily specify
> order. But all of these issues can be solved in follow-up patch.

Whatever you do, it should be designed cleanly and not introduce some
homegrown solution.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
