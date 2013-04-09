From: linfeng@cn.fujitsu.com (Lin Feng)
Date: Tue, 09 Apr 2013 10:02:27 +0800
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
Message-ID: <516376B3.90207@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yinghai,

On 04/09/2013 02:40 AM, Yinghai Lu wrote:
> On Mon, Apr 8, 2013 at 2:56 AM, Lin Feng <linfeng@cn.fujitsu.com> wrote:
>> In hot add node(memory) case, vmemmap pages are always allocated from other
>> node,
> 
> that is broken, and should be fixed.
> vmemmap should be on local node even for hot add node.
> 

Have you ever sent any relative patchset on this, maybe we can run some test
on it ;-)

thanks,
linfeng
