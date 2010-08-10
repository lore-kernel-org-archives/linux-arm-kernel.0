From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 10 Aug 2010 14:52:20 +0530
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <4C5FCBE1.2080303@st.com>
References: <4C5F9B25.8080401@st.com>
	<20100809064957.GB16661@pengutronix.de>	<4C5FA698.90904@st.com>
	<20100809090137.GP13165@mea-ext.zmailer.org> <4C5FCBE1.2080303@st.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401D8F0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

viresh kumar wrote:
> On 8/9/2010 2:31 PM, Matti Aarnio wrote:
> > On Mon, Aug 09, 2010 at 12:26:24PM +0530, viresh kumar wrote:
> >> > 
> >> > I missed this information in my last mail. We are using git send-email for
> >> > sending patches. As patches will go through Microsoft exchange server only,
> >> > so they are broken.
> >> > 
> > Let your boss complain to your IT keepers.
> > "These are Machine-to-Machine messages, they must not be modified!"
> > 
> > 
> > It would probably be "against corporate policy" to use gmail for these emails...
> > 
> 
> We got one solution: Upgrade Exchange server to SP2.
> Lets see if our IT department does this upgradation.
> 

Upgrading the Exchange server worked for us a couple of years ago. At least
git-send-email works okay now, but Outlook is horribly broken.

You could use gmail/others and send externally. Adding an explicit
"From :" line in the patch can still give you credits to your official
email address.

- Anand
