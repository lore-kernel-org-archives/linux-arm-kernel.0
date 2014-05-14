From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 May 2014 13:55:29 +0200
Subject: [PATCH] of: Add of_device_destroy_children() function
In-Reply-To: <20140514102754.BC60BC4153D@trevor.secretlab.ca>
References: <1399567069-3174-1-git-send-email-s.nawrocki@samsung.com>
 <20140514102754.BC60BC4153D@trevor.secretlab.ca>
Message-ID: <537359B1.1060908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/14 12:27, Grant Likely wrote:
> On Thu, 08 May 2014 18:37:49 +0200, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>> > This patch adds a helper function to unregister devices which
>> > were created by an of_platform_populate() call. The pattern
>> > used here can already be found in multiple drivers. This helper
>> > can now be used instead of repeating similar code in drivers.
>> > 
>> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>
> Pawel has also submitted a patch for this. That patch is a little more
> careful about how it removes nodes, so I'll be going with that one.

OK, it's good to know we have already a good solution. I'll give a try
Pawel's patch then.

Thanks,
Sylwester
