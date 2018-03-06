From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Mar 2018 19:10:01 -0300
Subject: Regulator regression in next-20180305
In-Reply-To: <20180306213350.GH13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk>
 <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
 <20180306213350.GH13586@sirena.org.uk>
Message-ID: <CAOMZO5BPyY3WUYUhV76HGdb_NbCv9riFdtEFaku2k4dd9-A_FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 6:33 PM, Mark Brown <broonie@kernel.org> wrote:

> No, unfortunately, apart from the generic kernel ones (like lockdep).
> I'll try to have a poke at adding some tomorrow, though I'm also
> considering just dropping the series for now.

Ok, lockdep is already enabled by default in the defconfig I am using
(imx_v6_v7_defconfig).

Yesterday I spent a few hours trying to understand this locking issue,
but didn't get any success on this task.

Thanks
