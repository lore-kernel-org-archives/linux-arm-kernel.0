From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 6 Aug 2014 13:53:46 +0200
Subject: [PATCH] i2c:at91: add bound checking on smbus block length bytes
In-Reply-To: <CAJjB1qJvvaO3PtN5dMAAAeABS5YMmRc1VRwKo6G_ZuDuo6L15g@mail.gmail.com>
References: <1404457391-22330-1-git-send-email-mark.roszko@gmail.com>
 <CAJjB1qJvvaO3PtN5dMAAAeABS5YMmRc1VRwKo6G_ZuDuo6L15g@mail.gmail.com>
Message-ID: <20140806115346.GB27338@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Aug 04, 2014 at 12:29:56PM -0400, Mark Roszko wrote:
> Hi Ludovic,
> 
> Have you had a chance to look? This causes kernel panic in at91 systems in
> noisy environments and/or unreliable smbus slaves if left unfixed.

Thanks for the reminder, I had totally missed this patch.

Seems good, no objection to include this patch.

Only one comment: s/recieved/received otherwise

Acked-By: Ludovic Desroches <ludovic.desroches@atmel.com>

Sorry for the delay.

Ludovic
