From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2012 09:09:13 +0100
Subject: For buddy system initialization, the holes between banks
 adjacent will be released to buddy allocator?
In-Reply-To: <CAFNq8R7fCyD5P4mAA8LGzcOvVynSJa8mOBDwrLOF9mVvo9q5VA@mail.gmail.com>
References: <CAFNq8R6kBonhW4Q+Zj_6GV7y88pcAUJ_MrYn1nYM9LHtMZqdvQ@mail.gmail.com>
 <CAFNq8R7fCyD5P4mAA8LGzcOvVynSJa8mOBDwrLOF9mVvo9q5VA@mail.gmail.com>
Message-ID: <20120827080913.GL18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 10:42:40AM +0800, Li Haifeng wrote:
> Just now, I tested it on my ARM development board.
> 
> The holes between banks does be released to buddy allocator. And the
> buddy system will allocate holes for thread, which will cause fault.
> Is it right?

Could you rephrase your question please?
