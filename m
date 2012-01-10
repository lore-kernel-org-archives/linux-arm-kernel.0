From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jan 2012 08:39:33 +0000
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <CA+55aFyaOnJhrZOFnRiShH9kTeGEG8O8m9spvKF=c36QzjSvBA@mail.gmail.com>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <1326147171-13752-6-git-send-email-arnd@arndb.de>
 <CA+55aFyaOnJhrZOFnRiShH9kTeGEG8O8m9spvKF=c36QzjSvBA@mail.gmail.com>
Message-ID: <20120110083933.GS21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 02:37:17PM -0800, Linus Torvalds wrote:
> Please do use -M, because it ends up making diffstats *so* much more
> readable when there are renames (instead of big delete-create diffs,
> you get a small diffstat that actually is much more relevant to what
> happened).

What about using -C instead (which implies -M, but also detects copies) ?
