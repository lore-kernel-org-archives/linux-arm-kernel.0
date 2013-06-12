From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 12 Jun 2013 09:37:06 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130611230845.GB13892@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130609014506.GB10027@obsidianresearch.com>
 <20130611135737.GC3996@localhost> <20835253.Agl4DfuI3k@wuerfel>
 <20130611215023.GA12649@obsidianresearch.com> <51B7A325.8070108@gmail.com>
 <20130611230845.GB13892@obsidianresearch.com>
Message-ID: <51B82522.5010903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 01:08 AM, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2013 at 12:22:29AM +0200, Sebastian Hesselbarth wrote:
>> sorry to kick into this thread that late but Ezequiel made me think of
>> address windows when asking on IRC. From what I can see from your and
>> Arnd's proposal the only real difference is that having it Arnd's way
>> allows you to have two or more windows mapped to e.g. devbus with
>> totally independent address ranges - while yours requires one large
>> window for all child devices?
>
> Sorry, I'm having problems following the possessives in your paragraph
> - which things are you comparing?

Ahh, just forget what I said. I see you two wrapped you mind a dozen
times more around it. I am starting to get the idea and its "beauty" ;)

Sebastian
