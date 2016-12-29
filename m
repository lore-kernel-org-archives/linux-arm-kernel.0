From: slash.tmp@free.fr (Mason)
Date: Thu, 29 Dec 2016 15:27:12 +0100
Subject: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
In-Reply-To: <9134f2dd-73f6-73d5-30a0-3129d5440d0a@free.fr>
References: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
 <CADjb_WQ8ZTtcXYQ_3iobLCW7+rnG8FqyFQ1E47AZVGxP0JyB0w@mail.gmail.com>
 <8c3c6592-1e9a-10d3-2a89-c22a2a23cf4b@free.fr>
 <9134f2dd-73f6-73d5-30a0-3129d5440d0a@free.fr>
Message-ID: <4dc90086-180d-df9a-297f-6f4680de7bdd@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 11:18 PM, Mason wrote:

> However, while Linux successfully starts the secondary cores when
> the system first boots, it fails when the system resumes from "S3".

Oh boy...

Turns out the firmware was, in fact, (upon resume) stomping over parts
of the Linux memory image in RAM, triggering all kinds of "interesting"
nasal demons when Linux ran (or, more accurately, limped).

The guilty party will be properly dealt with. (Where's my foam bat?)

Regards.
