From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 22 Nov 2009 09:33:35 -0600
Subject: 2.6.32-rc7: compile regression on spitz
In-Reply-To: <1258555133.3454.2.camel@hammer.suse.cz>
References: <20091118090100.GA1399@ucw.cz>
	<1258555133.3454.2.camel@hammer.suse.cz>
Message-ID: <f17812d70911220733va9997a1ibb6bbc8551f9c613@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/18 Stanislav Brabec <utx@penguin.cz>:
> Pavel Machek wrote:
>> If CONFIG_AKITA is not set, spitz fails to compile. It worked ok in
>> rc5. Fix is one more ifdef...
>
> That was my mistake in 5e0fa3f.
>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Stanislav Brabec <utx@penguin.cz>
>

Applied to 'fix'.
