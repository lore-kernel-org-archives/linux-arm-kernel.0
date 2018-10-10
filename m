From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Wed, 10 Oct 2018 23:57:14 +0200
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4
In-Reply-To: <20181008060500.GI3587@dragon>
References: <1538663639-3427-1-git-send-email-kueffner.markus@gmail.com>
 <20181008060500.GI3587@dragon>
Message-ID: <b032e50b-c189-8f9f-739e-30afb6ddfb33@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.2018 08:05, Shawn Guo wrote:
> Add a few udoo board users for comment.
> 
> On Thu, Oct 04, 2018 at 04:33:59PM +0200, Markus Kueffner wrote:
>> From: Markus Kueffner <kueffner.markus@gmail.com>
>>
>> Add Pincfgs for UART4 to enable Communication with the onboard SAM3X

Although I can't test this patch on a real board, verifying it with
UDOO schematic and docs suggests that this change does make sense.

Maciej
