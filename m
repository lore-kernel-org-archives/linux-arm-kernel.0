From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 24 Oct 2015 16:28:28 +0200
Subject: [PATCH v6 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <20151022235419.GF29919@sirena.org.uk>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com>
 <20151022235419.GF29919@sirena.org.uk>
Message-ID: <3439880.XMRknxAf8e@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 23, 2015 08:54:19 AM Mark Brown wrote:
> 
> --7cm2iqirTL37Ot+N
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Thu, Oct 22, 2015 at 03:03:37PM +0200, Tomeu Vizoso wrote:
> > On 22 October 2015 at 03:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > > Same question as from Greg: How does a subsystem know whether or not to use
> > > this function?
> 
> > Maybe I don't understand the comment, but as the commit message says,
> > subsystems can use this when looking up resources for drivers. Or you
> > mean that this information should be in the API docs?
> 
> I'm pretty sure what he's suggesting here is changing to "should always"
> (ie, explain the situations when a subsystem would do this, including
> decision criteria if it's optional).

Right.

Thanks,
Rafael
