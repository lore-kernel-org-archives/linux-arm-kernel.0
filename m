From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 5 May 2017 13:53:03 +0200
Subject: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 0/3] arm64: queued
 spinlocks and rw-locks
In-Reply-To: <20170504202809.lv222a3oes54ijkj@yury-N73SV>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <SIXPR0199MB0604CF9C101455F7D7417FF7C5160@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>
 <20170504202809.lv222a3oes54ijkj@yury-N73SV>
Message-ID: <20170505115303.s3bsu4adfgkxrhh2@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 11:28:09PM +0300, Yury Norov wrote:
> I don't think
> it's a real use case to have ticket spinlocks and queued rwlocks

There's nothing wrong with that combination. In fact, we merged qrwlock
much earlier than qspinlock.
