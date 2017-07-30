From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Sun, 30 Jul 2017 22:34:12 +0200
Subject: [PATCH v2 0/3] ASoC: fix unbalanced of_node_get()/of_node_put()
In-Reply-To: <20170728100735.enwrl7whjkmnicd7@sirena.org.uk>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
 <20170727232612.23543-1-antonio.borneo@st.com>
 <20170728100735.enwrl7whjkmnicd7@sirena.org.uk>
Message-ID: <CAAj6DX1F3eg61_EfqAa3-OKpPhEwN-dTkcEjgzxGeTsoZX_k1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 12:07 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 28, 2017 at 01:26:09AM +0200, Antonio Borneo wrote:
>> From: Antonio Borneo <borneo.antonio@gmail.com>
>>
>> On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
>> errors at kernel boot, like
>> OF: ERROR: Bad of_node_put() on /soc/i2s at f7118000/ports/port at 0
>> OF: ERROR: Bad of_node_put() on /soc/i2s at f7118000/ports/port at 0/endpoint
>> each followed by stack dump.
>
> Please take a look at the patches that Tony Lindgren has posted in the
> past day for this issue which go into the of_graph API to make it less
> error prone.

Great, it fixes the issue!
Please drop this patchset, the issue is completely covered by Tony's work.

Best Regards
Antonio
