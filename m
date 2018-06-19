From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Jun 2018 20:24:20 -0000
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <20100809064957.GB16661@pengutronix.de>
References: <4C5F9B25.8080401@st.com> <20100809064957.GB16661@pengutronix.de>
Message-ID: <4C5FA698.90904@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/9/2010 12:19 PM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Aug 09, 2010 at 11:37:33AM +0530, viresh kumar wrote:
>> > Hello,
>> > 
>> > Mail server in ST has recently changed and now we have Microsoft
>> > exchange server. We are using thunderbird as mail client.
>> > What we observed with this server is that patch are broken now while
>> > sending as well as receiving. Tabs are replaced by spaces and may
>> > be some other too which we haven't observed.
> unlucky you.
>  
>> > Has anybody found a solution to this kind of issues? Are there any
>> > workarounds possible?
> git.git has some tips for thunderbird, see
> 
> 	http://git.kernel.org/?p=git/git.git;a=blob;f=Documentation/SubmittingPatches;hb=HEAD
> 
> and look for the section titled "Thunderbird" (small surprise).

I missed this information in my last mail. We are using git send-email for
sending patches. As patches will go through Microsoft exchange server only,
so they are broken.

With previous server everything was working fine.

viresh.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
