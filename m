From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Jun 2018 20:24:16 -0000
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <4C5F9B25.8080401@st.com>
References: <4C5F9B25.8080401@st.com>
Message-ID: <20100809064957.GB16661@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Aug 09, 2010 at 11:37:33AM +0530, viresh kumar wrote:
> Hello,
> 
> Mail server in ST has recently changed and now we have Microsoft
> exchange server. We are using thunderbird as mail client.
> What we observed with this server is that patch are broken now while
> sending as well as receiving. Tabs are replaced by spaces and may
> be some other too which we haven't observed.
unlucky you.
 
> Has anybody found a solution to this kind of issues? Are there any
> workarounds possible?
git.git has some tips for thunderbird, see

	http://git.kernel.org/?p=git/git.git;a=blob;f=Documentation/SubmittingPatches;hb=HEAD

and look for the section titled "Thunderbird" (small surprise).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
