From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:31:41 +0000
Subject: [PATCHv2 2/2] ARM: socfpga: Add clock entries into device tree
In-Reply-To: <1363782295.12746.7.camel@linux-builds1>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <20130319221233.8663.40135@quantum> <1363782295.12746.7.camel@linux-builds1>
Message-ID: <201303201231.42241.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 March 2013, Dinh Nguyen wrote:
> > That is a fair comparison.  However I still prefer to see data (e.g. dts
> > changes) separated from logic (clk.c changes).  I think it makes for a
> > cleaner git history and makes patches more readable too.
> 
> I agree that it makes things alot cleaner to split DTS and code into
> separate patches, but at the same time the code is pretty much useless
> without the DTS entries. I apologize if there has already been a similar
> discussion on the list about this. I just want to make sure that I know
> to split up patches in the same manner in the future?

In particular, it would be helpful to merge the dts changes through the
arm-soc tree and the clk changes through Mike's clock tree. Ideally those
two should be completely independent of one another, although you obviously
need both to get the new feature.

	Arnd
