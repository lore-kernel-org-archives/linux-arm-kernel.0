From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 4 Nov 2013 09:47:08 +0100
Subject: [PATCH] clk: Properly initialize reference count
In-Reply-To: <1383220962-26836-1-git-send-email-treding@nvidia.com>
References: <1383220962-26836-1-git-send-email-treding@nvidia.com>
Message-ID: <CACmBeS3ZuzaQmb+V10Je8+9NyXzdULWKTcm9R4ZjE=DdiNN+oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2013 13:02, Thierry Reding <thierry.reding@gmail.com> wrote:
> Commit a336ed7 (clk: Implement clk_unregister()) initializes the kref in
> clk_set_parent(), which is obviously the wrong place. Further research
> shows that the original patches initialized it correctly, so it probably
> ended up in clk_set_parent() by mistake during manual application of the
> patch.

Tested-by: Jonas Jensen <jonas.jensen@gmail.com>

Thanks!
