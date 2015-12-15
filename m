From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 15 Dec 2015 19:34:13 +0000
Subject: [PATCH v10 0/6] QEMU support for KVM Guest Debug on arm64
In-Reply-To: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
References: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA8xQzgz8oSL=WtammyRjckBbyJqvzvQo54TfCj9yovaTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 December 2015 at 18:32, Alex Benn?e <alex.bennee@linaro.org> wrote:
> Hi,
>
> Here is the latest patch set to support debugging of KVM guests on
> arm64. The main changes are fixing arm32 compiles (mostly with stubs
> for the upcomming arm32 debug) and the usual bunch of minor tweaks and
> clarifications following review.
>
> I've kept the GDB Python based test in tests/guest-debug and cleaned
> it up so it will work with python2/3 linked GDBs. It still isn't
> plumbed it in to the "make check" so can be dropped until we have a
> solution for testing against non-host binaries.
>
> So in summary the changes are:
>
>   - Fixed arm32 compile
>   - Use results of debug capability checks
>   - Whitespace and comment cleanups
>   - Py2/3 cleanliness for test script
>
> More detailed changelogs are attached to each patch.

Thanks, applied to target-arm.next. (I fixed a few typos
in comments and commit messages in a couple of places).

-- PMM
