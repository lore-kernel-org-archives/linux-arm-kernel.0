From: yinghai@kernel.org (Yinghai Lu)
Date: Mon, 8 Apr 2013 11:40:11 -0700
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
Message-ID: <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 8, 2013 at 2:56 AM, Lin Feng <linfeng@cn.fujitsu.com> wrote:
> In hot add node(memory) case, vmemmap pages are always allocated from other
> node,

that is broken, and should be fixed.
vmemmap should be on local node even for hot add node.

Thanks

Yinghai
