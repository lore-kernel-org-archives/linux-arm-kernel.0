From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 20 Apr 2017 02:38:10 +0200
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <20170420103427.62fbf195@canb.auug.org.au>
References: <20170420103427.62fbf195@canb.auug.org.au>
Message-ID: <4444301.nE19g0hn7H@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 20, 2017 10:34:27 AM Stephen Rothwell wrote:
> Hi Rafael,
> 
> Today's linux-next merge of the pm tree got a conflict in:
> 
>   arch/arm/boot/dts/sun8i-a33.dtsi
> 
> between commits:
> 
>   66c373228dc4 ("ARM: sun8i: a33: Add the Mali OPPs")
>   e6bd37627e92 ("ARM: sun8i: a33: add all operating points")
> 
> from the arm-soc tree and commit:
> 
>   d87bd1942058 ("PM / OPP: Use - instead of @ for DT entries")
> 
> from the pm tree.

Thanks for the report!

I'm going to drop the conflicting commit tomorrow.

Thanks,
Rafael
