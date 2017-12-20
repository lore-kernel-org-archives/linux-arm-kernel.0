From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 20 Dec 2017 12:22:38 +0000
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <20171220120104.GA5724@afzalpc>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
 <20171219112954.GA14910@afzalpc>
 <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
 <20171220045219.GA6416@afzalpc>
 <b0e23a0b-8488-b1bc-8afe-cd68e47b9ad6@arm.com>
 <20171220114924.GA5377@afzalpc> <20171220120104.GA5724@afzalpc>
Message-ID: <38fb32ef-9e2f-01c0-c89f-7d05fe8bcf60@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/12/17 12:01, afzal mohammed wrote:
> Hi Vladimir,
> 
> To add, i am not against your patch, just seeing if we can avoid
> having this change, lesser code ... lesser bugs.

Look, I hit that issue and without this change the issue does not
magically disappear for me - the only way to avoid this change is
to propose alternative patch.

I don't want to jump into these "it should not happen" or "nobody"
cares" discussions just because it is not true - it happened to
me and I do care. However, I do open to discuss technical aspects.

Cheers
Vladimir

> 
> afzal
> 
