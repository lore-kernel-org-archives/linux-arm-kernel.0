From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Tue, 10 Oct 2017 13:07:35 -0400
Subject: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
In-Reply-To: <20171010155619.GA2517@arm.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
Message-ID: <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thank you for doing this work. How would you like to proceed?

- If you OK for my series to be accepted as-is, so your patch can be
added later on top, I think, I need an ack from you for kasan changes.
- Otherwise, I can replace: 4267aaf1d279 arm64/kasan: add and use
kasan_map_populate() in my series with code from your patch.

Thank you,
Pavel
