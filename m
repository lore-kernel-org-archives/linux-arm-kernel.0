From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 17 Jun 2013 15:12:45 +0530
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.11
In-Reply-To: <20130617090647.GX1403@sirena.org.uk>
References: <1371193161-25224-1-git-send-email-nsekhar@ti.com>
 <20130614222519.GK17326@quad.lixom.net> <20130617090647.GX1403@sirena.org.uk>
Message-ID: <51BEDA15.4090908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 6/17/2013 2:36 PM, Mark Brown wrote:
> On Fri, Jun 14, 2013 at 03:25:19PM -0700, Olof Johansson wrote:
> 
>> Ok. I'll hold off since Mark was interested in seeing the code. Please resend
>> once you have acks.
> 
> It should be OK to go.  I did actually find a bug when reviewing but the
> fix was to remove the offending driver since it's been broken for years.

Since I have sent you a patch removing SFFSDR support, I will also
re-spin this pull request to drop those hunks. I will send the patch out
shortly, please do ack it.

Thanks,
Sekhar
