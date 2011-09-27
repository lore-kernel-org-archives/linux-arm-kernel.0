From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Sep 2011 10:36:24 -0700
Subject: [PATCH v2 2/3] arm/tegra: add support for ventana pinmuxing
In-Reply-To: <1317143421-27286-3-git-send-email-pdeschrijver@nvidia.com>
References: <1317143421-27286-1-git-send-email-pdeschrijver@nvidia.com>
	<1317143421-27286-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAOesGMjqhGYUQ2XmuBBTBSUA6mKnOLF=Hmi86hRQhLiUMPtiBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The series looks reasonable to me, I'll apply it together with some of
the other pending tegra patches from the list. Once Stephen's pinmux
devicetree code is in place some of this can be removed.

One comment on this patch description though:


On Tue, Sep 27, 2011 at 10:10 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> Add support for ventana pinmuxing as a seaboard derivative. This is a cut down
> version of chromeos kernel commit 772f1b56e713be7a55759c2d5eadb9eb11d078db
> by Jong Kim <jongk@nvidia.com>.

Having a reference to a SHA1 in a foreign source tree isn't really
useful in the mainline kernel commit log.

I would just phrase it "This is a cut down version of work done by <....>"


-Olof
