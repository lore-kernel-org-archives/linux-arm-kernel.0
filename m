From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 1 Aug 2017 14:37:03 +0300
Subject: [PATCH RFC] arm64: introduce mm_context_t flags
In-Reply-To: <5e0f1ae7-3a69-0d1c-3f33-ddb44ed8b6c5@redhat.com>
References: <20170731144825.31322-1-ynorov@caviumnetworks.com>
 <5e0f1ae7-3a69-0d1c-3f33-ddb44ed8b6c5@redhat.com>
Message-ID: <20170801113703.ufn7tg2lvn4mr3so@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 09:10:05AM +0530, Pratyush Anand wrote:
> 
> 
> On Monday 31 July 2017 08:18 PM, Yury Norov wrote:
> >   - If we start using TIF flags here, we cannot easily add new mm_context
> >     specific bits because they may mess with TIF ones.
> 
> This one seems convincing argument. ATM do you have any mm_context flag
> which would you like to incorporate?

I think no

Yury
