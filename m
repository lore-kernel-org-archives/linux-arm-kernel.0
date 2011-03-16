From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 16 Mar 2011 16:55:02 +0300
Subject: [PATCH v2] z2-battery: Fix count of properties
In-Reply-To: <201103112236.14261.marek.vasut@gmail.com>
References: <4D7A1181.2000802@ru.mvista.com>
	<1299848972-25596-1-git-send-email-anarsoul@gmail.com>
	<201103112236.14261.marek.vasut@gmail.com>
Message-ID: <20110316135502.GA18052@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 10:36:14PM +0100, Marek Vasut wrote:
> On Friday 11 March 2011 14:09:32 Vasily Khoruzhick wrote:
> > PROP_STATUS property was not counted, as result
> > VOLTAGE_MIN property is missing in sysfs. Fix it.
> > 
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> You can have my:
> 
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> 
> on this one.

Applied, thanks guys!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
