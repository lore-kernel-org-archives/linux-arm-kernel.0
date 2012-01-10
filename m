From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jan 2012 15:57:47 +0200
Subject: How to configure SGTL5000 ASoC as master?
In-Reply-To: <7FE21149F4667147B645348EC605788508AA69@039-SN2MPN1-013.039d.mgd.msft.net>
References: <4F0BD878.40508@bluegiga.com>
 <7FE21149F4667147B645348EC605788508AA69@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <4F0C43DB.1070000@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2012 08:43 AM, Dong Aisheng-B29396 wrote:
>> SGTL5000 ASoC is hard coded to be slave in sound/soc/mxs/mxs-sgtl5000.c.
> Yes, Saif TX can only work on master mode so we simply only support master mode
> for both saif rx/tx.

You are right. I didn't notice that before. Thanks.

Lauri
