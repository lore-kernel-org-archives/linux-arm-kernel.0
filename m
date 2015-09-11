From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 11 Sep 2015 16:58:08 -0500
Subject: [GIT PULL] arm64: updates for 4.3
In-Reply-To: <20150910170257.GH22439@arm.com>
References: <20150904102656.GC4818@arm.com>
 <CAOZdJXX_avYXi9JSk=Ge6fuBLzS1n2jd7yBmhnFx4u_ptvNS5A@mail.gmail.com>
 <20150910170257.GH22439@arm.com>
Message-ID: <CAOZdJXWwLJBwGZ0tDMi6wmoAU0uiDBuE-Hb+ytR1isQQsk02Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 12:02 PM, Will Deacon <will.deacon@arm.com> wrote:

>> [v5] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
>> [v3] hvc_dcc: don't ignore errors during initialization
>
> Those patches should go via the usual route for tty changes (i.e. Greg).
> I merged the arm64 change here because it (a) makes sense as a standalone
> patch and (b) is a dependency for your other stuff.

Greg,

Any chance these patches can get into 4.3-rc1?

https://patchwork.kernel.org/patch/7039851/
https://patchwork.kernel.org/patch/7039841/
