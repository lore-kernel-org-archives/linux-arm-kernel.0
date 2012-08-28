From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 28 Aug 2012 08:03:18 +0200
Subject: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
In-Reply-To: <20120827233756.GH2281@r65073-Latitude-D630>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <20120827223134.GD2281@r65073-Latitude-D630>
 <20120827225142.GA11302@kroah.com>
 <20120827233756.GH2281@r65073-Latitude-D630>
Message-ID: <503C5F26.4020108@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.08.2012 01:37, Shawn Guo wrote:
> On Mon, Aug 27, 2012 at 03:51:42PM -0700, Greg Kroah-Hartman wrote:
>> On both of them?  I can do that if needed.  How far back should they go?
>>
> It should be okay to apply on 3.4 and 3.5. 

For patch #1/2: Yes, thanks!

> But patch #2 is still in
> question.  I do not like the #ifdef.

For patch #2/2: Yes, understood. I'll look at Troy's proposal and will 
update #2/2.

Many thanks and best regards

Dirk
