From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Jul 2012 13:08:46 +0200
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <5017BBB0.1000702@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
 <CAMW5UfahXv--UU5np9HroXWia7-PN9qy1eyCnc_Wf39H-_F+gA@mail.gmail.com>
 <5017BBB0.1000702@codethink.co.uk>
Message-ID: <20120731110846.GA18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I see no reason to keep the calls now that the driver manages to
> hang onto its clocks.

Hi Ian

Did you test this with it built as a module? That is the real test....

    Andrew
