From: mihai.dontu@gmail.com (Mihai =?utf-8?q?Don=C8=9Bu?=)
Date: Mon, 9 Aug 2010 17:35:10 +0300
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <4C5FCDB4.1080909@gmail.com>
References: <4C5F9B25.8080401@st.com> <4C5FCBE1.2080303@st.com>
	<4C5FCDB4.1080909@gmail.com>
Message-ID: <201008091735.11105.mihai.dontu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 August 2010 12:43:16 Justin P. Mattock wrote:
> On 08/09/2010 02:35 AM, viresh kumar wrote:
> > On 8/9/2010 2:31 PM, Matti Aarnio wrote:
> >> On Mon, Aug 09, 2010 at 12:26:24PM +0530, viresh kumar wrote:
> >>>> I missed this information in my last mail. We are using git send-email
> >>>> for sending patches. As patches will go through Microsoft exchange
> >>>> server only, so they are broken.
> >> 
> >> Let your boss complain to your IT keepers.
> >> "These are Machine-to-Machine messages, they must not be modified!"
> >> 
> >> 
> >> It would probably be "against corporate policy" to use gmail for these
> >> emails...
> > 
> > We got one solution: Upgrade Exchange server to SP2.
> > Lets see if our IT department does this upgradation.
> 
> that or just blast them with some cryptology..i.e. pretty sure if your
> message was encapsulated(AH/ESP) they couldn't tweak it.. but then
> sending such encryption to a public list would require a _key_ on the
> other side.. wishful thinking...
> (just a thought)...

Shouldn't just signing the message be enough? The server (normally) would not 
alter it, otherwise it will break the signature (which is a too obvious bug 
even for Microsoft). Or am I missing something here?

PS: A local SMTP with DKIM signing capabilities could be another possibility, 
assuming Exchange does not break such signatures.

-- 
Mihai Don?u
