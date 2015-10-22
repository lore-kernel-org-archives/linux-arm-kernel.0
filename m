From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Oct 2015 08:54:19 +0900
Subject: [PATCH v6 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-5-git-send-email-tomeu.vizoso@collabora.com>
 <10119606.2TraDKGPVy@vostro.rjw.lan>
 <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com>
Message-ID: <20151022235419.GF29919@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 03:03:37PM +0200, Tomeu Vizoso wrote:
> On 22 October 2015 at 03:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> > Same question as from Greg: How does a subsystem know whether or not to use
> > this function?

> Maybe I don't understand the comment, but as the commit message says,
> subsystems can use this when looking up resources for drivers. Or you
> mean that this information should be in the API docs?

I'm pretty sure what he's suggesting here is changing to "should always"
(ie, explain the situations when a subsystem would do this, including
decision criteria if it's optional).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/4e3f79b4/attachment-0001.sig>
