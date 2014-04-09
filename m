From: bp@alien8.de (Borislav Petkov)
Date: Wed, 9 Apr 2014 17:24:31 +0200
Subject: [PATCH v6 4/5] edac: Add support for Krait CPU cache error
 detection
In-Reply-To: <53445407.1010108@codeaurora.org>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
 <1396641450-12854-5-git-send-email-sboyd@codeaurora.org>
 <20140408173541.GO30077@pd.tnic> <53445407.1010108@codeaurora.org>
Message-ID: <20140409152431.GL6529@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 12:54:47PM -0700, Stephen Boyd wrote:
> > and also, this message looks a bit cryptic for issuing it at ALERT
> > level. I'm ssuming people won't come to you and ask you what it
> > means...? :)
> 
> Ok. I can lower it to error level?

I'm just trying to put you in the user's shoes and make you take a
critical look at your error messages and ask yourself whether people
seeing this would know what's going on or not?

We've had the experience on x86 where people would have the *whole*
error message which would say, "error corrected, bla" and they still
would come and ask whether their hw is b0rked. We had to add stuff like:

	"Corrected error, no action required."

to let them know there was no affect on execution. And they'd still come
and ask. Even other kernel people! :-)

So please make sure your error messages are as understandable as
possible.

:-)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
