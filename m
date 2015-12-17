From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Dec 2015 09:48:42 +0000
Subject: [PATCH] locking/osq: fix ordering of node initialisation in
 osq_lock
In-Reply-To: <56720D78.9080706@gmail.com>
References: <1449856001-21177-1-git-send-email-will.deacon@arm.com>
 <56720D78.9080706@gmail.com>
Message-ID: <20151217094655.GA11456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 05:18:48PM -0800, David Daney wrote:
> What is the status of this patch?  It there a good likelihood that it will
> make it into v4.4?
> 
> If not, we should request that c55a6ffa6285 ("locking/osq: Relax atomic
> semantics") be reverted for v4.4

I think Peter was going to send it to mingo as an urgent fix, but I've
not seen anything from the tip-bot yet.

Will
