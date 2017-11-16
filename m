From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 16 Nov 2017 10:47:19 -0800
Subject: [GIT PULL] arm64: updates for 4.15
In-Reply-To: <20171116115138.GF9361@arm.com>
References: <20171114201132.GB18699@arm.com>
 <CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com>
 <20171116115138.GF9361@arm.com>
Message-ID: <CA+55aFzWk=n_GV1=JHdgQfJ2yQU6gXyG87v3J65xdBXWkfTyDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 3:51 AM, Will Deacon <will.deacon@arm.com> wrote:
> From: Will Deacon <will.deacon@arm.com>
> Date: Thu, 16 Nov 2017 10:49:34 +0000
> Subject: [PATCH] irqdesc: Use bool return type instead of int

Thomas, will you take this in the irq branches, or should I just apply
it directly because it's "one of Linus' hangups".

It's not urgent, there hopefully aren't actually any existing bad
cases, it's purely "future mis-use safety".

                 Linus
