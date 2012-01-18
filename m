From: mmarek@suse.cz (Michal Marek)
Date: Wed, 18 Jan 2012 11:07:58 +0100
Subject: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17801D2255@HQMAIL01.nvidia.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
 <1326310587.2535.291.camel@deneb.redhat.com> <4F1206F1.5090405@suse.cz>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D2255@HQMAIL01.nvidia.com>
Message-ID: <4F1699FE.5050005@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.1.2012 18:20, Stephen Warren wrote:
> Michal Marek wrote at Saturday, January 14, 2012 3:51 PM:
>> As the C6X port has been merged in this merge window, I can't easily
>> apply this patch to my kbuild branch and at the same time please Linus
>> by basing the pull request on a tagged release. So I'm going to drop the
>> arch/c6x part to keep the kbuild branch "pretty" and let either Mark or
>> Stephen send the patch to Linus directly, once he has merged the kbuild
>> branch. Would that work?
> 
> I was assuming my patches were for 3.4 rather than 3.3, since it's pretty
> late for new features in 3.3. In that case, there wouldn't be an issue,
> right?

OK, that was a misunderstanding then. I applied it to the kbuild branch
for 3.3 and Linus pulled it in the meantime. It's not a terribly
intrusive change, after all.

Michal
