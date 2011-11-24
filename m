From: rabin@rab.in (Rabin Vincent)
Date: Thu, 24 Nov 2011 21:40:42 +0530
Subject: [PATCH 2/4] ARM: extract out insn generation code from ftrace
In-Reply-To: <20111123115002.GA2050@localhost.localdomain>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-2-git-send-email-rabin@rab.in>
 <20111122120252.GE2066@localhost.localdomain>
 <CAH+eYFBz_aEeC3DwGF2mdpVepburzCBJqD0n1LFjL1y5dqOXHw@mail.gmail.com>
 <20111122135627.GH2066@localhost.localdomain>
 <CAH+eYFA2nhwXCU99RWyv1tncdz77dNHKqyX9bzSE31iepTRFYw@mail.gmail.com>
 <20111123115002.GA2050@localhost.localdomain>
Message-ID: <20111124161029.GA3787@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 11:50:12AM +0000, Dave Martin wrote:
> Are there any other dependencies on framepointers, or is that the only
> thing?

That's the only thing.
