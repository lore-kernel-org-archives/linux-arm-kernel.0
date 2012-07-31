From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 31 Jul 2012 12:39:10 +0100
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <20120731110846.GA18016@lunn.ch>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
 <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
 <5017BBB0.1000702@codethink.co.uk> <20120731110846.GA18016@lunn.ch>
Message-ID: <5017C3DE.8050302@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 12:08, Andrew Lunn wrote:
>> I see no reason to keep the calls now that the driver manages to
>> hang onto its clocks.
> Hi Ian
>
> Did you test this with it built as a module? That is the real test....

Rats. Yes, however it managed to survive. The minute I read this was the
minute it died. sods law :(

Guess it'll still be needed for now.

So, the question is about how to implement it - I like the 'probe the OF
device name' idea - I can implement that quickly enough.

Once thats done, I can push out a v2 patch, all the other issues are now
addressed, AFAICS.

-Ian
