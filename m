From: ccross@android.com (Colin Cross)
Date: Sat, 28 Jul 2012 18:09:24 -0700
Subject: ftrace: Trace function entry before updating index
In-Reply-To: <20120728101018.GD6802@n2100.arm.linux.org.uk>
References: <20120728101018.GD6802@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRRdb3v7Cs8CQXEin0pk2Kzs5O5v=rnX4uGYMKbfWxX3Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 3:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Any reason this patch doesn't have a CC'd to stable attributation?

The x86 fix went into 2.6.39, so it's been broken at least since then,
so I didn't consider it a regression, but I guess it should go to
stable.
